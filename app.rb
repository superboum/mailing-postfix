require 'sinatra'
require 'sinatra/config_file'
require 'json'
require 'haml'

require_relative 'lib/mailing_list_repository'
require_relative 'lib/mailing_list'

config_file 'config.yml'

set :haml, :format => :html5
set :public_folder, File.dirname(__FILE__) + '/static'

m = MailingListRepository.new(settings.alias_file, settings.reload_cmd)
m.load

get '/' do
    haml :index, :locals => {:m => m, :selected => -1}
end

get %r{/([\d]+)} do |id|
    haml :index, :locals => {:m => m, :selected => id.to_i}
end

post %r{/([\d]+)/add} do |id|
    m.lists[id.to_i].addSubscriber(params['subscriber'])
    m.save
    redirect to('/'+id), 303
end

post %r{/([\d]+)/rm} do |id|
    m.lists[id.to_i].removeSubscriber(params['subscriber'])
    m.save
    redirect to('/'+id), 303
end

post '/add' do
    m.add(params['mailing'])
    m.save
    redirect to('/'+ (m.lists.length-1).to_s), 303
end

post '/rm' do
    m.rm(params['mailing'].to_i)
    m.save
    redirect to('/'), 303
end
