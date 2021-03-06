require 'slim/include'
require 'sinatra/asset_pipeline'
require_relative 'lib/helpers/application_helper.rb'

module Website
  class Home < Sinatra::Base
    register Sinatra::Contrib
    
    helpers ApplicationHelper
    
    configure :production do
      set :assets_precompile, %w(main.js main.css *.png *.jpg *.svg *.eot *.ttf *.woff *.woff2)
      set :assets_css_compressor, :sass
      set :assets_js_compressor, :yui
      set :assets_protocol, :https
      set :static_cache_control, [:public, :must_revalidate, :max_age => 900000]
      register Sinatra::AssetPipeline
      Slim::Engine.options[:pretty] = false
    end
    
    configure :development do
      register Sinatra::Reloader
      Slim::Engine.options[:pretty] = true
    end
    
    before do
      cache_control :public, :must_revalidate, :max_age => 9000
    end
    
    get '/' do
      slim :index
    end
    
    get '/cv' do
      path = 'files/resume_java_-_vaibhav_yenamandra.pdf'
      
      send_file static_file(path), type: "application/pdf"
    end
    
    get '/blog' do
      redirect 'https://blog.theyenaman.me/'
    end
  end
end
