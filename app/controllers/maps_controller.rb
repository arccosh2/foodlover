class MapsController < ApplicationController

  def index
    require 'json'
    require 'httpclient'
    require 'uri'
    require 'will_paginate/array'

    api_key = ENV['HOT_API_KEY']
    lat = params["lat"].to_i
    lng = params["lng"].to_i
    distance = params[:distance_id]
    

    data = {
      "key": api_key,
      "range": distance,
      "lat": lat,
      "lng": lng,
      "format": "json"
    }
    

    query = data.to_query
    uri = URI('http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?'+query)

    client = HTTPClient.new
    client.connect_timeout = 100
    client.send_timeout    = 100
    client.receive_timeout = 100
    req = Net::HTTP::Get.new(uri)
    res = client.get(uri)
    res_data = JSON.parse(res.body, symbolize_names: true)

    @cafes = res_data[:results][:shop].paginate(page: params[:page], per_page: 5)
  end
    

  def detail
    @cafe = params.permit(:access, :address, :lat, :lng, :name, :pc, :catch, :open, {:genre => [:catch, :name]}, )
    @genre = params.require(:genre)
    @photo = params.require(:photo)
    gon.lat = @cafe[:lat]
    gon.lng = @cafe[:lng]
  end

 
end
