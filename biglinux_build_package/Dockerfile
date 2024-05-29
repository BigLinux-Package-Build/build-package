FROM manjarolinux/build:latest
RUN sed -i '/LocalFileSigLevel/{p;s/.*/ParallelDownloads = 8/;};/SyncFirst/d;/multilib/{s/#//;n;s/#//;}' /etc/pacman.conf \
    && pacman -Syu --noconfirm --needed \
      git \
      wget \
      nano \
      tmate \
      rsync \
      docker \
      openssh \
      github-cli \
      glibc-locales \
      manjaro-arm-tools \
      manjaro-chrootbuild \
      arch-install-scripts \
    && sed -i '/LocalFileSigLevel/{p;s/.*/ParallelDownloads = 8/;}' /etc/chrootbuild/pacman.conf.x86_64 /usr/share/manjaro-arm-tools/lib/pacman.conf.aarch64 \
    && sed -i '/multilib/{s/#//;n;s/#//;}' /etc/chrootbuild/pacman.conf.x86_64 /usr/share/manjaro-arm-tools/lib/pacman.conf.aarch64 \
    && sed -i '/SyncFirst/d' /etc/chrootbuild/pacman.conf.x86_64 /usr/share/manjaro-arm-tools/lib/pacman.conf.aarch64 \
    && pacman-key -r 45EC44879815E2A6 \
    && pacman-key --lsign-key 45EC44879815E2A6 \
    && pacman -Sy biglinux-keyring --noconfirm \
    && pacman-key --populate biglinux 
    
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
