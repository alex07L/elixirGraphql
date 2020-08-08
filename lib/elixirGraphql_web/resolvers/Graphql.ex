defmodule ElixirGraphqlWeb.Resolvers.Graphql do
    alias ElixirGraphql.Graphql
  
    def getIntervention(_, %{id: id}, _) do
      post = postgresql("SELECT employee_id, building_id, start_intervention, end_intervention FROM factintervention WHERE id="<>id)
      post = Enum.at(post, 0)
      mysql = mysql("SELECT a.street, a.suite, a.city, a.postalCode, a.country, b.id, b.fullName, b.email, b.cellPhone, b.techName, b.techPhone, b.techEmail, b.customer_id, d.infoKey, d.infoValue FROM buildings b JOIN addresses a ON a.id=b.address_id JOIN building_details d ON d.building_id=b.id WHERE b.id="<>to_string(Enum.at(post,1)))
      
      #IO.inspect(Enum.at(post,1))
      #bd = mysql("SELECT infoKey, infoValue FROM building_details WHERE building_id="<>Enum.at(post,1))
      d = for x <-mysql do
        %{infoKey: Enum.at(x,13), infoValue: Enum.at(x,14)}
      end
      mysql = Enum.at(mysql,0)
      {:ok, %{id: id, employee_id: Enum.at(post,0), building_id: Enum.at(post,1), start_intervention: Enum.at(post,2), end_intervention: Enum.at(post,3), build: %{id: Enum.at(mysql,5), address: %{street: Enum.at(mysql,0), suite: Enum.at(mysql,1), city: Enum.at(mysql,2), postalCode: Enum.at(mysql,3), country: Enum.at(mysql,4)}, fullName: Enum.at(mysql,6), email: Enum.at(mysql,7), cellPhone: Enum.at(mysql,8), techName: Enum.at(mysql,9), techEmail: Enum.at(mysql,10), customer_id: Enum.at(mysql,11), building_details: d}}}
      #{:ok, %{id: id}}
    end

    def getBuilding(_, %{id: id}, _) do
      post = postgresql("SELECT id, employee_id, building_id, start_intervention, end_intervention FROM factintervention WHERE building_id="<>id)
      #post = Enum.at(post, 0)
      mysql = mysql("SELECT a.street, a.suite, a.city, a.postalCode, a.country,c.entrepriseName , c.nameContact ,c.description, c.email, c.cellPhone ,c.authorityEmail ,c.authorityName, c.authorityPhone, a2.street AS 'Cstreet', a2.suite AS 'Csuite', a2.city AS 'Ccity', a2.postalCode AS 'CpostalCode', a2.country AS 'Ccountry', b.id, b.fullName, b.email, b.cellPhone, b.techName, b.techPhone, b.techEmail, b.customer_id FROM buildings b JOIN addresses a ON a.id=b.address_id JOIN customers c ON c.id= b.customer_id JOIN addresses a2 ON a2.id=c.address_id WHERE b.id="<>id)
      mysql = Enum.at(mysql,0)
      a = %{street: Enum.at(mysql,0), suite: Enum.at(mysql,1), city: Enum.at(mysql,2), postalCode: Enum.at(mysql,3), country: Enum.at(mysql,4)}
      c = %{entrepriseName: Enum.at(mysql,5), nameContact: Enum.at(mysql,6), description: Enum.at(mysql,7), email: Enum.at(mysql,8), cellPhone: Enum.at(mysql,9), authorityEmail: Enum.at(mysql,10), authorityName: Enum.at(mysql,11), autorityPhone: Enum.at(mysql,12), address: %{street: Enum.at(mysql,13), suite: Enum.at(mysql,14), city: Enum.at(mysql,15), postalCode: Enum.at(mysql,16), country: Enum.at(mysql,17)}}
      #IO.inspect(post)
      #bd = mysql("SELECT infoKey, infoValue FROM building_details WHERE building_id="<>Enum.at(post,2))
      #dd = for x <-bd do
        #%{infoKey: Enum.at(x,0), infoValue: Enum.at(x,1)}
      #end
      d = for x <- post do
        #IO.inspect(x)
        %{id: Enum.at(x, 0), employee_id: Enum.at(x, 1), building_id: Enum.at(x, 2), start_intervention: Enum.at(post,3), end_intervention: Enum.at(post,4),build: %{address: a, id: Enum.at(mysql,18), fullName: Enum.at(mysql,19), email: Enum.at(mysql,20), cellPhone: Enum.at(mysql,21), techName: Enum.at(mysql,22), techEmail: Enum.at(mysql,23), customer_id: Enum.at(mysql,24), building_details: nil}}
      end
      #IO.inspect(d)
      {:ok, %{id: id, customer: c, interventions: d}}
    end

    def getEmployee(_, %{id: id}, _) do
      post = postgresql("SELECT id, employee_id, building_id, start_intervention, end_intervention FROM factintervention WHERE employee_id="<>id)
      #post = Enum.at(post, 0)
      #IO.inspect(post)
      d = for x <- post do
        mysql = mysql("SELECT a.street, a.suite, a.city, a.postalCode, a.country, b.id, b.fullName, b.email, b.cellPhone, b.techName, b.techPhone, b.techEmail, b.customer_id, d.infoKey, d.infoValue FROM buildings b JOIN addresses a ON a.id=b.address_id JOIN building_details d ON d.building_id=b.id WHERE b.id="<>Enum.at(x, 2))
        #IO.inspect(x)
        #bd = mysql("SELECT infoKey, infoValue FROM building_details WHERE building_id="<>Enum.at(mysql,5))
        dd = for x <-mysql do
          %{infoKey: Enum.at(x,13), infoValue: Enum.at(x,14)}
        end
        mysql = Enum.at(mysql,0) 
        %{id: Enum.at(x, 5), employee_id: Enum.at(x, 6), building_id: Enum.at(x, 7), start_intervention: Enum.at(post,8), end_intervention: Enum.at(post,9), build: %{id: Enum.at(mysql,5), fullName: Enum.at(mysql,6), email: Enum.at(mysql,7), cellPhone: Enum.at(mysql,8), techName: Enum.at(mysql,9), techEmail: Enum.at(mysql,10), address: %{street: Enum.at(mysql,0), suite: Enum.at(mysql,1), city: Enum.at(mysql,2), postalCode: Enum.at(mysql,3), country: Enum.at(mysql,4)},customer_id: Enum.at(x, 11),  building_details: dd}}
      end
      #IO.inspect(d)
      e = mysql("SELECT email, firstName, lastName, title FROM employees WHERE id="<>Enum.at(post, 1))
      {:ok, %{id: id, firstname: Enum.at(e,1), lastname: Enum.at(e,2), email: Enum.at(e,1), title: Enum.at(e,3), interventions: d }}
    end

    def mysql(q) do
      {:ok, con} = MyXQL.start_link(username: "codeboxx", password: "Codeboxx1!", hostname: "codeboxx.cq6zrczewpu2.us-east-1.rds.amazonaws.com", database: "ThierryHarvey")
      {:ok, query} = MyXQL.prepare(con, "", q)
      {:ok,_query, %MyXQL.Result{rows: row}} = MyXQL.execute(con, query, [])
      MyXQL.close(con,query)
      row
    end

    def postgresql(q) do 
      {:ok, pid} = Postgrex.start_link(hostname: "codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com", username: "codeboxx", password: "Codeboxx1!", database: "ThierryHarvey")
      %Postgrex.Result{rows: row} = Postgrex.query!(pid, q, [])
      row
    end

end