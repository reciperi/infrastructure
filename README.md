### TODO
- [ ] Migrate from umbrella to monolithic on backend
- [ ] What do I want for a pre-ALPHA in data layer? Maybe just an app that list/create/update ingredients
- [ ] Investigate what are attributes interesting for ingredient
- [ ] JSON Web Token for API authentication
- [ ] Do some seed data

- [ ] Implement ssl on devenv
- [ ] Review `capistrano-phoenix` gem

### Resources for deploy Elixir apps
- [6 months with Elixir and Phoenix](https://medium.com/@elviovicosa/i-have-been-using-ruby-rails-for-8-years-and-although-ive-used-different-technologies-over-that-4a4933dae3e5)

- [Capistrano Phoenix](https://github.com/dabit/capistrano-phoenix) as a deploy strategy

### Translation of columns
https://github.com/crbelaus/trans

### Certificate
https://dennisreimann.de/articles/phoenix-nginx-config.html
https://www.digitalocean.com/community/tutorials/how-to-set-up-let-s-encrypt-with-nginx-server-blocks-on-ubuntu-16-04
https://forge.puppet.com/puppet/letsencrypt

### DONE
- [x] Hiera don't take `subenvironment` as `FACTER_SUBENVIRONMENT` in command line
- [x] Talk with Jose what modules are basic for implement it. Ex.: ssh, groups, ?
- [x] PostgreSQL puppet module. Decript error run provision
- [x] Learn to configure Postgresql. Just setup user with password
- [x] Fixed Capistrano local deploy creating `current` release folder.
- [x] Try to fix magec/xenial64 hanging on vagrant halt
- [x] Ansible provision in Linux
- [x] Puppet provision in Linux
- [x] Fix new secrect key on config file on PostgreSQL
- [x] Setup Ansible and Puppet in Linux
- [x] Lxc container accessible on port 80. It was /etc/hosts wrong on my host machine
- [x] Setup env variables from puppet. Review [file_line](http://www.puppetmodule.info/github/simp/puppetlabs-stdlib/puppet_types/file_line) as a way to write from different Puppet modules into the same `.env` file
- [x] Provision Phoenix installer with mix package manager (Hex)
- [x] Initialize Phoenix app.
- [x] Put Phoenix app under Nginx. Provision
- [x] Do an Ecto table for recipes (Just a field for `name`)
- [x] Copy from F!: How is deployed code on devenv? For what it's used development_devenv_localhost.rb?
- [x] Setup [absinthe](https://github.com/absinthe-graphql/absinthe) as GraphQL server
- [x] Play with Graphicl
- [x] ~Translate with `trans`?~ Each locale will have the ingridients list. It's too complicated to join the same ingredient across locales if we want clients create ingredients. Although we should have a lot ingredients created before go public.
