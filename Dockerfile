#################################
# madoos/ci-test #
#################################

FROM node:6-slim

MAINTAINER Maurice Dominguez <maurice@caseonit.com>

ENV USER dockerfileUser

# Libraries for node-gyp build zmq, bzip2 and git (for cloning private npm)
RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean -y && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Copy our App
WORKDIR /home/$USER/
ADD . .

# Change to non-root user
RUN groupadd --system $USER --gid 433 && \
    useradd --uid 431 --system --gid $USER --shell /sbin/nologin --comment "User inside Docker containers" $USER && \
    chown -R $USER:$USER /home/$USER
USER $USER

# Install Node dependencies and remove NPM cache
RUN npm install --production && \
    npm cache clean && \
    rm -rf /home/$user/.node-gyp && \
    rm -rf /tmp/npm-*

# Removed unnecessary packages and return to non-root user
USER $USER

# Expose app ports
EXPOSE 3000

# Optimize NodeJS for production
ENV NODE_ENV=production

CMD [ "npm", "start" ]