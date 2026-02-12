use std::fmt;
use std::sync::Arc;
use std::sync::atomic::AtomicBool;
use std::sync::mpsc::{Receiver, Sender};
use std::time::{Duration, SystemTime};

const TRANSMISSION_TIMEOUT: Duration = Duration::from_millis(100);

#[derive(Clone, Copy, Debug)]
#[repr(transparent)]
pub struct TransmissionTimestamp(u64);

impl TransmissionTimestamp {
    pub fn now() -> Self {
        Self(
            SystemTime::now()
                .duration_since(SystemTime::UNIX_EPOCH)
                .unwrap()
                .as_millis() as u64,
        )
    }

    pub fn elapsed(&self) -> Duration {
        let now = Self::now();

        Duration::from_millis(now.0 - self.0)
    }
}

#[derive(Clone, Debug)]
pub struct TransmissionState {
    pub sending: Arc<AtomicBool>,
    pub receiving: Arc<AtomicBool>,
}

pub struct TransmissionStateReceiver {
    rx_channel: Receiver<TransmissionTimestamp>,
    tx_channel: Receiver<TransmissionTimestamp>,
    last_received: Option<TransmissionTimestamp>,
    last_sent: Option<TransmissionTimestamp>,
    sending: Arc<AtomicBool>,
    receiving: Arc<AtomicBool>,
}

impl TransmissionStateReceiver {
    pub fn get_state(&self) -> TransmissionState {
        TransmissionState {
            sending: self.sending.clone(),
            receiving: self.receiving.clone(),
        }
    }

    pub fn process(&mut self) {
        if let Ok(timestamp) = self.rx_channel.try_recv() {
            self.last_received = Some(timestamp);
        }
        if let Ok(timestamp) = self.tx_channel.try_recv() {
            self.last_sent = Some(timestamp);
        }
        if let Some(last_received) = self.last_received {
            self.receiving.store(
                last_received.elapsed() < TRANSMISSION_TIMEOUT,
                std::sync::atomic::Ordering::Relaxed,
            );
        }
        if let Some(last_sent) = self.last_sent {
            self.sending.store(
                last_sent.elapsed() < TRANSMISSION_TIMEOUT,
                std::sync::atomic::Ordering::Relaxed,
            );
        }
    }
}

pub struct TransmissionStateSender {
    rx_channel: Sender<TransmissionTimestamp>,
    tx_channel: Sender<TransmissionTimestamp>,
}

impl fmt::Debug for TransmissionStateSender {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.debug_struct("TransmissionStateSender").finish()
    }
}

impl TransmissionStateSender {
    pub fn received_packet(&self) {
        if let Err(err) = self.rx_channel.send(TransmissionTimestamp::now()) {
            tracing::error!("Failed to send received packet timestamp: {err:?}");
        }
    }

    pub fn sent_packet(&self) {
        if let Err(err) = self.tx_channel.send(TransmissionTimestamp::now()) {
            tracing::error!("Failed to send sent packet timestamp: {err:?}");
        }
    }
}

pub(crate) fn create_transmission_state() -> (TransmissionStateSender, TransmissionStateReceiver) {
    let (rx_sender, rx_receiver) = std::sync::mpsc::channel();
    let (tx_sender, tx_receiver) = std::sync::mpsc::channel();

    (
        TransmissionStateSender {
            rx_channel: rx_sender,
            tx_channel: tx_sender,
        },
        TransmissionStateReceiver {
            rx_channel: rx_receiver,
            tx_channel: tx_receiver,
            last_received: None,
            last_sent: None,
            sending: Arc::new(AtomicBool::new(false)),
            receiving: Arc::new(AtomicBool::new(false)),
        },
    )
}
