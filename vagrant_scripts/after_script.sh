cd flashcards

bundle install

echo "${PWD##*/}"
if ! [ -a "./config/database.yml" ]; then
 echo "database.yml not exist"
 cp ./config/database.yml.example ./config/database.yml
 echo "database.yml created"
fi
bundle exec rake db:create
bundle exec rake db:migrate
echo "${PWD##*/}"
