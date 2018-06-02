class users::root {
  users::user { 'root':
    create_resource => false,
  }
}
