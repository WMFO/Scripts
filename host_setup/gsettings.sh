# run as wmfo-dj user to remove menu things
gsettings set com.canonical.indicator.sound visible false
gsettings set com.canonical.indicator.bluetooth visible false
gsettings set com.canonical.indicator.keyboard visible false
kill `pgrep nm-applet`

