# Any subsequent(*) commands which fail will cause the shell script to exit immediately
set -e
#=========
# Chrome
#=========
apt-get update -y &&
    apt-get install -yqq wget curl gnupg unzip zip jq xvfb &&
    rm -rf /var/lib/apt/lists/*

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >>/etc/apt/sources.list.d/google.list
apt-get update -y
apt-get install -y $CHROMEVERSION
#=========
# Chromedriver
#=========
chromedriver_latest=$(curl -sS https://chromedriver.storage.googleapis.com/LATEST_RELEASE)
wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/$chromedriver_latest/chromedriver_linux64.zip
unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/
#=========
# Firefox
#=========
apt-get update -y &&
    apt-get install --no-install-recommends --no-install-suggests -y \
        libgtk-3-0 libdbus-glib-1-2 bzip2
DL='https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64' &&
    curl -sL "$DL" | tar -xj -C /opt &&
    ln -s /opt/firefox/firefox /usr/local/bin/ &&
    #=========
    # Geckodriver
    #=========
    BASE_URL=https://github.com/mozilla/geckodriver/releases/download &&
    VERSION=$(curl -sL https://api.github.com/repos/mozilla/geckodriver/releases/latest | jq -r ".tag_name") &&
    curl -sL "$BASE_URL/$VERSION/geckodriver-$VERSION-linux64.tar.gz" > /tmp/geckodriver.tar.gz &&
    echo "$BASE_URL/$VERSION/geckodriver-$VERSION-linux64.tar.gz" &&
    tar -C /usr/local/bin -zxvf /tmp/geckodriver.tar.gz
# Remove obsolete files:
apt-get autoremove --purge -y &&
    bzip2 &&
    apt-get clean &&
    rm -rf \
        /tmp/* \
        /usr/share/doc/* \
        /var/cache/* \
        /var/lib/apt/lists/* \
        /var/tmp/*
# Revert exit on error
set +e
