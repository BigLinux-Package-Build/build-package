FROM manjarolinux/base:latest as base

# squashing the whole base image into one layer
FROM scratch AS build
COPY --from=base / /

COPY pacman.conf /etc/pacman.conf

ARG TARGETPLATFORM

ARG CACHEBUST=1
ENV LANG=en_US.UTF-8

ENV PATH="/usr/bin:${PATH}"

RUN uname -m \
    && pacman-key --init \
    && echo 'Server = https://mirrors2.manjaro.org/stable/$repo/$arch' > /etc/pacman.d/mirrorlist \
    && pacman-key -r 45EC44879815E2A6 \
    && pacman-key --lsign-key 45EC44879815E2A6 \
    && cp /etc/pacman.conf /etc/pacman.conf-bkp \
    && pacman -Syyu --noconfirm --needed archlinux-keyring manjaro-keyring biglinux-keyring \
    && mv /etc/pacman.conf-bkp /etc/pacman.conf \
    && pacman-key --populate archlinux manjaro biglinux \
    && pacman -Qeq |  grep -q ^ && pacman -D --asdeps $(pacman -Qeq) || echo "nothing to set as dependency" \
    && pacman -S --asexplicit --needed --noconfirm base \
    && pacman -S --asexplicit --needed --noconfirm \
        lsb-release \
        manjaro-release \
        pacman \
        sed \
        git \
        wget \
        nano \
        tmate \
        rsync \
        docker \
        openssh \
        github-cli \
        glibc-locales \
        manjaro-chrootbuild \
    && pacman -Qtdq | grep -v base && pacman -Rsunc --noconfirm  $(pacman -Qtdq | grep -v base) systemd || echo "nothing to remove" \
    rm -f /usr/include/bits/struct_stat.h \
       /usr/include/bits/types/struct___jmp_buf_tag.h \
       /usr/include/bits/types/struct_timeb.h \
       /usr/share/locale/sr/LC_MESSAGES/libc.mo \
    && pacman -Syy glibc --noconfirm \
    && pacman -Syu --noconfirm \
    && sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen \
    && locale-gen \
    && rm -f /var/cache/pacman/pkg/* \
    && for i in $(ls /usr/lib/locale | grep -v en_US); do rm -r /usr/lib/locale/$i; done \
    && for i in $(ls /usr/share/locale | grep -v en_US); do rm -r /usr/share/locale/$i; done \
    && rm -rf /usr/share/{doc,man}
    
## final docker image 
FROM scratch AS release

COPY --from=build / /

CMD ["/usr/bin/sh"]
