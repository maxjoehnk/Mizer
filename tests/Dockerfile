FROM python:3.14

# Install system dependencies:
#  - Xvfb: headless X server
#  - dbus / at-spi2: accessibility framework (required by dogtail)
#  - GTK/GLib: needed by dogtail introspection
#  - scrot: screenshot tool used by the test harness
#  - libgl1: OpenGL support (needed by opencv-python)
#  - Various libs the mizer binary likely depends on
# Install runtime + build dependencies in one layer.
# python3-gi is for Debian's system Python; we also need build deps to compile
# PyGObject (pycairo + pygobject) for the Docker-image Python 3.14.
RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    dbus \
    dbus-x11 \
    at-spi2-core \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libatspi2.0-0 \
    libgtk-3-0 \
    gobject-introspection \
    gir1.2-atspi-2.0 \
    gir1.2-gtk-3.0 \
    scrot \
    libgl1 \
    libglib2.0-0 \
    libx11-6 \
    libxext6 \
    libxrender1 \
    libxrandr2 \
    libxcursor1 \
    libxi6 \
    libxtst6 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxkbcommon0 \
    libwayland-client0 \
    libfontconfig1 \
    libfreetype6 \
    libegl1 \
    libgles2 \
    libvulkan1 \
    libusb-1.0-0 \
    libasound2 \
    x11-utils \
    pipenv \
    # Node.js for Allure 3 report generation (npx allure)
    nodejs \
    npm \
    # Build deps for PyGObject / pycairo (pip install)
    build-essential \
    pkg-config \
    libgirepository-2.0-dev \
    libcairo2-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app/tests

# Copy dependency files and install Python packages
COPY Pipfile Pipfile.lock ./
RUN pipenv install --system --deploy

# Install PyGObject for the Docker-image Python (apt python3-gi only covers
# Debian's system Python, which is a different version).
RUN pip install --no-cache-dir pycairo PyGObject

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Xvfb display configuration
ENV DISPLAY=:99
ENV XVFB_RESOLUTION=1920x1080x24
ENV XDG_SESSION_TYPE=x11

# AT-SPI / dogtail configuration
ENV DBUS_SESSION_BUS_ADDRESS=autolaunch:
ENV GTK_MODULES=gail:atk-bridge
ENV NO_AT_BRIDGE=0

# Test sources and mizer.zip are mounted at runtime:
#   -v ./:/app/tests
#   -v ../mizer.zip:/app/mizer.zip
ENTRYPOINT ["/entrypoint.sh"]
CMD ["behave"]
