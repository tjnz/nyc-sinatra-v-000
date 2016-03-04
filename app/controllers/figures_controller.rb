class FiguresController < ApplicationController
	
	get '/figures/new' do 
		@titles = Title.all
		@landmarks = Landmark.all
		erb :'/figures/new'
	end
	
	post '/figures' do
		figure = Figure.create(params[:figure])
		if !params[:title][:name].empty? 
			figure.titles << Title.create(params[:title])
		end
		if !params[:landmark][:name].empty? 
			figure.landmarks << Landmark.create(params[:landmark])
		end
		figure.save
		redirect "/figures/#{figure.id}"
	end
	
	get '/figures' do 
		@figures = Figure.all
		erb :'/figures/index'
	end
	
	get '/figures/:id' do 
		@figure = Figure.find(params[:id])
		erb :'/figures/show'
	end
	
	patch '/figures/:id' do 
		@figure = Figure.find(params[:id])
		@figure.update(params[:figure])
		@figure.landmark_ids = params[:figure][:landmark_ids]
		@figure.title_ids = params[:figure][:title_ids]
		
		if !params[:title][:name].empty? 
			@figure.titles << Title.create(params[:title])
		end
		if !params[:landmark][:name].empty? 
			@figure.landmarks << Landmark.create(params[:landmark])
		end
		@figure.save
		erb :'/figures/show'
	end
	
	get '/figures/:id/edit' do 
		@figure = Figure.find(params[:id])
		@titles = Title.all
		@landmarks = Landmark.all
		erb :'/figures/edit'
	end
	
	delete '/figures/:id' do 
		Figure.find(params[:id]).destroy
		redirect '/figures'
	end
	
end
