class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create name: params[:pet_name]

    existing_owner = params[:owner_ids]

    if existing_owner && existing_owner.any?
      @pet.owner = Owner.find(params[:owner_ids].first)
      @pet.save
    end

    if !params[:owner_name].empty?
      @pet.owner = Owner.create(name: params[:owner_name])
      @pet.save
    end

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find params[:id]
    @owners = Owner.all
    erb :'pets/edit'
  end

  post '/pets/:id/update' do
    @pet = Pet.find params[:id]

    if params[:pet_name]
      @pet.name = params[:pet_name]
      @pet.save
    end
    
    existing_owner = params[:owner_ids]

    if existing_owner && existing_owner.any?
      @pet.owner = Owner.find(params[:owner_ids].first)
      @pet.save
    end

    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
      @pet.save
    end

    raise @pet.owner.name.inspect
    raise params.inspect
    redirect "/pets/#{@pet.id}"
  end
end
