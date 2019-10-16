
![PlantUML model](http://www.plantuml.com/plantuml/png/XOzD2i8m48NtFKNeKkZ26xI8Mn740qoJAA7vAPC9LSIxEpPAKrmuYq3UU_CDhuq4ICdPAWx6Zu3WH0zok698Nks23IXEFanL9NZEKQEej_McQVYTlvsKdAJiGny9GPAG5cAS_GSRUPgBmKW7S7gHB1JACqFoRgUSyUQDeu12tqXxzIN-flTkjE6kzIgudCuBHVu8PBIdlzoYOL4aiRhkCN9u2gW-X9QXoTaN)

```plantuml
@startuml Account Management
    skinparam backgroundColor Snow

    User "1"*--"1" UserAccount

    abstract class User{
        -firstName
        -lastName
    }

    class Administrator extends User{

    }

    class Employee extends User{
        
    }
    class Patient extends User{

    }

    class UserAccount{
        -userName
        -password
    }
@enduml
```
