FROM manjarolinux/build:latest
RUN sed -i '/LocalFileSigLevel/{s/.*/ParallelDownloads = 8/;}; /SyncFirst/d; /#\[multilib\]/{s/#//;n;s/#//;}; /multilib repositories/d' /etc/pacman.conf \
    && echo 'Server = https://mirrors2.manjaro.org/stable/$repo/$arch' > /etc/pacman.d/mirrorlist \
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
    && cp /etc/pacman.conf /etc/pacman.conf-bkp \
    && echo -e '\n[biglinux-stable]\nSigLevel = PackageRequired\nServer = https://repo.biglinux.com.br/stable/$arch' | tee -a /etc/pacman.conf \
    && pacman -Sy biglinux-keyring --noconfirm \
    && mv /etc/pacman.conf-bkp /etc/pacman.conf \
    && pacman-key --populate biglinux 
    
COPY docker-entrypoint.sh /
COPY docker-entrypoint.sh /usr/local/bin/tail

ENTRYPOINT ["/docker-entrypoint.sh"]
