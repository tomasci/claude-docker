1. First build the image (only do this once)

	```bash
	docker compose build
	```

2. Claude login (once)

	Run the container with a dummy path just to login

	```bash
	TARGET_PROJECT=$PWD docker compose run --rm claude login
	```

3. Run this to open project folder in claude code

	```bash
	TARGET_PROJECT=~/dev/my-react-app docker compose run --rm claude
	```

4. Add these lines to your `~/.zprofile`

	```bash
	# optional; use to reload your shell
	alias reload='source ~/.zprofile'
	# command to run claude code in any project folder
	# run pwd command in claude-docker folder to get path
	alias claude-docker='~/<path_to>/claude-docker/claude-docker' # notice last /claude-docker is script to run
	```
