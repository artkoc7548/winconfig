git clone https://github.com/artkoc7548/winconfig.git
git init
git status

git add .

git rm -r -f --cached .

git comit 
echo "# winconfig" >> README.md
git init
git add README.md
git commit -m "windows konigurator ver 1.0"
git remote add origin https://github.com/artkoc7548/winconfig.git
git push -u origin master

git pul origin master

git branch fitcher