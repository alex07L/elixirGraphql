# Rocket_Elevators_GraphQL IN java

To start your Phoenix server:

  * Start Phoenix endpoint with `mix phx.server`


## Question 1: Get address of a building and information of a intervention
You can change the id of intervention. this id is the id of a intervention
```
intervention(id: 4){
  id
  building_id
  employee_id
  start_intervention
  end_intervention
  address{
    street
    suite
    city
    postalCode
    country
  }
}
```
## Question 2: Get all interventions of a building and the customer related to it
You can change the id by a id of building
```
buildings(id: 2){
  id
  customer{
    email
  }
  interventions{
    id
    building_id
    employee_id
    start_intervention
    end_intervention
  }
  address{
    street
    suite
    city
    postalCode
    country
  }
}
```

## Question 3: Get all interventions made by an employee
You can change id by a id of a employee
```
{
    employee(id: 3){
  firstName
  lastName
  email
  title
  interventions{
    building_id
    start_intervention
    end_intervention
    build{
      fullName
      email
      cellPhone
      techName
      techEmail
      address{
        street
        city
        country
        postalCode
      }
      building_details{
        key
        value
      }
    }
    }
  }
}
```



