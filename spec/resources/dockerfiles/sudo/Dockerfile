FROM debian:9-slim

RUN apt-get update && apt-get -y install sudo

RUN useradd -G sudo user1
RUN groupadd group1
RUN groupadd group2
RUN groupadd group3
RUN groupadd group4

RUN useradd -G  group1,group4 user2
RUN useradd -G  group3 user3
RUN useradd -G  group2 user4
RUN useradd user5
RUN useradd -G group2 user6


RUN echo '%sudo ALL=(group3) NOPASSWD:ALL' >> /etc/sudoers
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN echo '%group1 ALL=(ALL) ALL' >> /etc/sudoers
RUN echo '%group2 ALL=(user5) ALL' >> /etc/sudoers
RUN echo '%group2 ALL=(user6) NOPASSWD: /usr/bin/cat /var/log/messages' >> /etc/sudoers
RUN echo '%group2 ALL=(user6) /usr/bin/cat /var/log/secure' >> /etc/sudoers
RUN echo '%group3 ALL=(ALL) NOPASSWD: /usr/bin/cat /var/log/messages' >> /etc/sudoers
RUN echo '%group4 ALL=(ALL) /usr/bin/cat /tmp/logs' >> /etc/sudoers

CMD /bin/bash && tail -f /dev/null