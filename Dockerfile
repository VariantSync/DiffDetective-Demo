FROM openjdk:23-slim


RUN apt-get update
RUN apt-get install -y --no-install-recommends bash maven git
# Create a user
RUN useradd --create-home --shell /bin/bash user
RUN mkdir -p /home/user && chown -R user:user /home/user

WORKDIR /home/user
COPY docker/* ./

# TODO: select specific release
RUN git clone https://github.com/VariantSync/DiffDetective.git
WORKDIR /home/user/DiffDetective
RUN mvn install

WORKDIR /home/user
# Adjust permissions
RUN chown user:user /home/user -R
RUN chmod +x run-demo.sh
RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh", "./run-demo.sh"]
USER user
