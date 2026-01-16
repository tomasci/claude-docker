# Use a full Node image
FROM node:24-bookworm

# Install common development tools
RUN apt-get update && apt-get install -y \
	git \
	curl \
	wget \
	python3 \
	python3-pip \
	python3-venv \
	zip \
	unzip \
	nano \
	vim \
	build-essential \
	&& rm -rf /var/lib/apt/lists/*

# Install Claude Code globally
RUN npm install -g @anthropic-ai/claude-code

# Setup User Arguments
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG USER_NAME=claude

# MAC FIX: Check if the group ID already exists.
# If it does (like ID 20), we use the existing group.
# If not, we create the new 'claude' group.
RUN if ! getent group ${GROUP_ID} > /dev/null; then \
	groupadd -g ${GROUP_ID} ${USER_NAME}; \
	fi && \
	useradd -m -u ${USER_ID} -g ${GROUP_ID} -s /bin/bash ${USER_NAME}

# Create working directories
# FIX APPLIED HERE: We use ${USER_ID}:${GROUP_ID} instead of names
RUN mkdir -p /app /home/${USER_NAME}/.claude /home/${USER_NAME}/.npm && \
	chown -R ${USER_ID}:${GROUP_ID} /app /home/${USER_NAME}/.claude /home/${USER_NAME}/.npm

USER ${USER_NAME}
WORKDIR /app

# Set environment variables
ENV CLAUDE_CONFIG_DIR=/home/${USER_NAME}/.claude
ENV NPM_CONFIG_PREFIX=/home/${USER_NAME}/.npm-global
ENV PATH=$PATH:/home/${USER_NAME}/.npm-global/bin

ENTRYPOINT ["claude"]
