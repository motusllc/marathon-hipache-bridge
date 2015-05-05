FROM webratio/gvm

# Defines environment variables
ENV GROOVY_VERSION 2.4.1

# Installs Groovy 
RUN /bin/bash -c "source /root/.gvm/bin/gvm-init.sh && gvm install groovy ${GROOVY_VERSION}"
ENV GROOVY_HOME /root/.gvm/groovy/current
ENV PATH $GROOVY_HOME/bin:$PATH

# Add source file
ADD . .

# Install grapes
RUN /bin/bash -c "source /src/install-grapes.sh"

# Switch working directory
WORKDIR ./src