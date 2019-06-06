class PetsController < ApplicationController

  # Display what is in the index file from views/pets folders.
  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  # Display a new form to fill out.
  get '/pets/new' do
    erb :'/pets/new'
  end

  # Add and save the information from the form to the database
  post '/pets' do
    @pet = Pet.create(params["pet"])

    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end

    @pet.save

    redirect to "pets/#{@pet.id}"
  end

  # Display a form to modify a previous Record
  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  # Display a form to modify a previous Record
  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  # Add and save the modified information to the database
  post '/pets/:id' do
    @pet = Pet.find(params[:id])

    @pet.update(params["pet"])

    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end

    @pet.save

    redirect to "pets/#{@pet.id}"
  end
end
