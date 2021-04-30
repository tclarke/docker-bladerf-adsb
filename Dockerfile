FROM bladerf

RUN mkdir -p /src
WORKDIR /src

RUN sudo apt-get install --yes build-essential librtlsdr-dev pkg-config libncurses5-dev

RUN git clone https://github.com/flightaware/dump1090 && \
	cd dump1090 && \
        make LIMESDR=no HACKRF=no BLADERF=no

COPY bias-tee.patch /src/
RUN git clone https://github.com/Nuand/bladeRF-adsb && \
    cd bladeRF-adsb/bladeRF_adsb && \
    git apply /src/bias-tee.patch && \
    make 

RUN cd /bladeRF-images && \
    wget https://www.nuand.com/fpga/adsbxA4.rbf && \
    wget https://www.nuand.com/fpga/adsbxA9.rbf && \
    wget https://www.nuand.com/fpga/adsbx40.rbf && \
    wget https://www.nuand.com/fpga/adsbx115.rbf 

COPY ./run.sh /src/run.sh
CMD ["/src/run.sh"]
