class PetsController < ApplicationController

  # Display what is in the index file from views/pets folders.
  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

 # Display a new form to fill out.
  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  # Add and save the information from the form to the database
  post '/pets' do
    # binding.pry
    @pet = Pet.create(params[:pet])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(params[:owner])
      @pet.save
    end

    redirect to "pets/#{@pet.id}"
  end

  # Display a form to modify by taking it from the database
  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  # Display a form to modify a previous Record
    get '/pets/:id/edit' do
      @pet = Pet.find(params[:id])
      @owners = Owner.all
      erb :'/pets/edit'
    end

  # Add and save the modified information to the database
  post '/pets/:id' do
    # binding.pry
    @pet = Pet.find params[:id]
    @pet.update(params[:pet])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(params[:owner])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
