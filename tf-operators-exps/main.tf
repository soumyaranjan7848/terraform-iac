terraform {}

# Number list
variable "num_list"{
    type    = list(number)
    default = [ 1,2,3,4,5 ]
}  

# Object list of person
variable "person_list" {
  type = list(object({
    fname = string
    lname = string 
  }))
  default = [ {
    fname = "Raju"
    lname = "Rastogi"
  },{
    fname = "Sham"
    lname = "paul"
  } ]
}

variable "map_list" {
  type = map(number)
  default = {
    "one"   = 1
    "two"   = 2
    "three" = 3
  }
}

# Claculation
locals {
  mul = 2*8
  add = 2+2
  eq  = 2 != 3

  # double the list
double = [for num in var.num_list : num*2]
 # odd number only
odd = [for num in var.num_list : num if num %2!=0]
# To get only fname from person list
fname_list = [for person in var.person_list: person.fname]
# WORK with map
map_info = [for key, value in var.map_list: key]
}

output "output" {
  value = local.mul
}

output "output" {
  value = local.double/odd/fname_list/map_info
}

output "list" {
  value = var.num_list
}