defmodule ElixirGraphqlWeb.Schema.Schema do
    use Absinthe.Schema
  
    query do
  
      @desc "Get a intervention by its id"
      field :intervention, :intervention do
        arg :id, non_null(:id)
        resolve &ElixirGraphqlWeb.Resolvers.Graphql.getIntervention/3
      end

      @desc "Get a customers and intervention by building id"
      field :building, :building do
        arg :id, non_null(:id)
        resolve &ElixirGraphqlWeb.Resolvers.Graphql.getBuilding/3
      end

      @desc "Get a customers and intervention by building id"
      field :employee, :employee do
        arg :id, non_null(:id)
        resolve &ElixirGraphqlWeb.Resolvers.Graphql.getEmployee/3
      end
    end
  
    object :place do
      field :id, non_null(:id)
    end

    object :address do
        field :street, :string
        field :suite, :string
        field :city, :string
        field :postalCode, :string
        field :country, :string
    end

    object :intervention do
        field :id, :string
        field :employee_id, :string
        field :buidling_id, :string
        field :start_intervention, :string
        field :end_intervention, :string
        field :build, :build
    end

    object :customer do
        field :entrepriseName, :string
        field :nameContact, :string
        field :cellPhone, :string
        field :email, :string
        field :description, :string
        field :authorityName, :string
        field :authorityPhone, :string
        field :authorityEmail, :string
        field :address, :address
    end

    object :building do
        field :id, :string
        field :address, :address
        field :customer, :customer
        field :interventions, list_of(:intervention)
    end

    object :building_details do
      field :infoValue, :string
      field :infoKey, :string
    end

    object :build do
      field :id, :string
      field :fullName, :string
      field :email, :string
      field :cellPhone, :string
      field :techName, :string
      field :techEmail, :string
      field :address, :address
      field :customer_id, :string
      field :building_details, list_of(:building_details)
    end

    object :employee do
        field :id, :string
        field :firstName, :string
        field :lastName, :string
        field :email, :string
        field :title, :string
        field :interventions, list_of(:intervention)
    end

  end