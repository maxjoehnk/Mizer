use citp::protocol::{caex, pinf, Header, Kind, SizeBytes};

pub const CITP_HEADER_LEN: usize = 20;
pub const CONTENT_TYPE_LEN: usize = 4;

pub fn layer_two_content_type(data: &[u8], header_size: usize) -> u32 {
    let slice = &data[header_size..header_size + CONTENT_TYPE_LEN];
    u32::from_le_bytes([slice[0], slice[1], slice[2], slice[3]])
}

pub fn build_pinf_msg<T: SizeBytes>(msg: T, content_type: &[u8; 4]) -> pinf::Message<T> {
    pinf::Message {
        pinf_header: pinf::Header {
            citp_header: citp_header(msg.size_bytes(), pinf::Header::CONTENT_TYPE),
            content_type: u32::from_le_bytes(*content_type),
        },
        message: msg,
    }
}

pub fn build_caex_msg<T: SizeBytes>(msg: T, content_type: &[u8; 4]) -> caex::Message<T> {
    caex::Message {
        caex_header: caex::Header {
            content_type: u32::from_le_bytes(*content_type),
            citp_header: citp_header(msg.size_bytes(), caex::Header::CONTENT_TYPE),
        },
        message: msg,
    }
}

fn citp_header(message_size: usize, content_type: &[u8; 4]) -> Header {
    Header {
        cookie: u32::from_le_bytes(*b"CITP"),
        version_major: 1,
        version_minor: 0,
        kind: Kind { request_index: 0 },
        message_size: (CITP_HEADER_LEN + CONTENT_TYPE_LEN + message_size) as u32,
        message_part_count: 1,
        message_part: 0,
        content_type: u32::from_le_bytes(*content_type),
    }
}
