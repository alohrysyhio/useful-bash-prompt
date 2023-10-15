# A useful bash prompt

## Here is how it looks:
![Here is how it looks](/resource/demo.png)

## Installation:
### In one command: 
This will create a `.bash-ubp/` directory in your `home/`
```bash
cd ~ && git clone https://github.com/alohrysyhio/useful-bash-prompt .bash-ubp && echo ". ~/.bash-ubp/useful-bash-prompt.sh" >> ~/.bashrc && source ~/.bashrc
```

## Uninstallation:
### Also in one command:
This will delete the `.bash-ubp/` directory and any line in `.bashrc` that has the string `".bash-ubp"`
```bash
sed -i '/.bash-ubp/d' ~/.bashrc && rm -rf ~/.bash-ubp && source ~/.bashrc && exec bash
```
