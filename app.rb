require 'sinatra'
require 'sinatra/config_file'
require 'json'
require 'haml'

require_relative 'lib/mailing_list_repository'
require_relative 'lib/mailing_list'

config_file 'config.yml'

set :haml, :format => :html5
set :public_folder, File.dirname(__FILE__) + '/static'

m = MailingListRepository.new(settings.alias_file)
m.load

get '/' do
    haml :index, :locals => {:m => m, :selected => -1}
end

get '/:id' do
    haml :index, :locals => {:m => m, :selected => params['id'].to_i}

end
