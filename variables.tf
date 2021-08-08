variable "name" {
  description = "Site name."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{0,64}$", var.name))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "description" {
  description = "Site description."
  type        = string
  default     = ""

  validation {
    condition     = can(regex("^[a-zA-Z0-9\\!#$%()*,-./:;@ _{|}~?&+]{0,128}$", var.description))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `\\`, `!`, `#`, `$`, `%`, `(`, `)`, `*`, `,`, `-`, `.`, `/`, `:`, `;`, `@`, ` `, `_`, `{`, `|`, }`, `~`, `?`, `&`, `+`. Maximum characters: 128."
  }
}

variable "buildings" {
  description = "List of buildings. Allowed values `id`: 1-4000. Allowed values `pod`: 1-255. Default value `pod`: 1."
  type = list(object({
    name        = string
    description = optional(string)
    floors = optional(list(object({
      name        = string
      description = optional(string)
      rooms = optional(list(object({
        name        = string
        description = optional(string)
        rows = optional(list(object({
          name        = string
          description = optional(string)
          racks = optional(list(object({
            name        = string
            description = optional(string)
            nodes = optional(list(object({
              id  = number
              pod = optional(number)
            })))
          })))
        })))
      })))
    })))
  }))
  default = []

  validation {
    condition = alltrue([
      for b in var.buildings : can(regex("^[a-zA-Z0-9_.-]{0,64}$", b.name))
    ])
    error_message = "`buildings.name`: Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }

  validation {
    condition = alltrue([
      for b in var.buildings : b.description == null || can(regex("^[a-zA-Z0-9\\!#$%()*,-./:;@ _{|}~?&+]{0,128}$", b.description))
    ])
    error_message = "`buildings.description`: Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `\\`, `!`, `#`, `$`, `%`, `(`, `)`, `*`, `,`, `-`, `.`, `/`, `:`, `;`, `@`, ` `, `_`, `{`, `|`, }`, `~`, `?`, `&`, `+`. Maximum characters: 128."
  }

  validation {
    condition = alltrue(flatten([
      for b in var.buildings : [for f in coalesce(b.floors, []) : can(regex("^[a-zA-Z0-9_.-]{0,64}$", f.name))]
    ]))
    error_message = "`floors.name`: Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }

  validation {
    condition = alltrue(flatten([
      for b in var.buildings : [for f in coalesce(b.floors, []) : f.description == null || can(regex("^[a-zA-Z0-9\\!#$%()*,-./:;@ _{|}~?&+]{0,128}$", f.description))]
    ]))
    error_message = "`floors.description`: Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `\\`, `!`, `#`, `$`, `%`, `(`, `)`, `*`, `,`, `-`, `.`, `/`, `:`, `;`, `@`, ` `, `_`, `{`, `|`, }`, `~`, `?`, `&`, `+`. Maximum characters: 128."
  }

  validation {
    condition = alltrue(flatten([
      for b in var.buildings : [for f in coalesce(b.floors, []) : [for r in coalesce(f.rooms, []) : can(regex("^[a-zA-Z0-9_.-]{0,64}$", r.name))]]
    ]))
    error_message = "`rooms.name`: Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }

  validation {
    condition = alltrue(flatten([
      for b in var.buildings : [for f in coalesce(b.floors, []) : [for r in coalesce(f.rooms, []) : r.description == null || can(regex("^[a-zA-Z0-9\\!#$%()*,-./:;@ _{|}~?&+]{0,128}$", r.description))]]
    ]))
    error_message = "`rooms.description`: Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `\\`, `!`, `#`, `$`, `%`, `(`, `)`, `*`, `,`, `-`, `.`, `/`, `:`, `;`, `@`, ` `, `_`, `{`, `|`, }`, `~`, `?`, `&`, `+`. Maximum characters: 128."
  }

  validation {
    condition = alltrue(flatten([
      for b in var.buildings : [for f in coalesce(b.floors, []) : [for r in coalesce(f.rooms, []) : [for row in coalesce(r.rows, []) : can(regex("^[a-zA-Z0-9_.-]{0,64}$", row.name))]]]
    ]))
    error_message = "`rows.name`: Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }

  validation {
    condition = alltrue(flatten([
      for b in var.buildings : [for f in coalesce(b.floors, []) : [for r in coalesce(f.rooms, []) : [for row in coalesce(r.rows, []) : row.description == null || can(regex("^[a-zA-Z0-9\\!#$%()*,-./:;@ _{|}~?&+]{0,128}$", row.description))]]]
    ]))
    error_message = "`rows.description`: Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `\\`, `!`, `#`, `$`, `%`, `(`, `)`, `*`, `,`, `-`, `.`, `/`, `:`, `;`, `@`, ` `, `_`, `{`, `|`, }`, `~`, `?`, `&`, `+`. Maximum characters: 128."
  }

  validation {
    condition = alltrue(flatten([
      for b in var.buildings : [for f in coalesce(b.floors, []) : [for r in coalesce(f.rooms, []) : [for row in coalesce(r.rows, []) : [for rack in coalesce(row.racks, []) : can(regex("^[a-zA-Z0-9_.-]{0,64}$", rack.name))]]]]
    ]))
    error_message = "`racks.name`: Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }

  validation {
    condition = alltrue(flatten([
      for b in var.buildings : [for f in coalesce(b.floors, []) : [for r in coalesce(f.rooms, []) : [for row in coalesce(r.rows, []) : [for rack in coalesce(row.racks, []) : rack.description == null || can(regex("^[a-zA-Z0-9\\!#$%()*,-./:;@ _{|}~?&+]{0,128}$", rack.description))]]]]
    ]))
    error_message = "`racks.description`: Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `\\`, `!`, `#`, `$`, `%`, `(`, `)`, `*`, `,`, `-`, `.`, `/`, `:`, `;`, `@`, ` `, `_`, `{`, `|`, }`, `~`, `?`, `&`, `+`. Maximum characters: 128."
  }

  validation {
    condition = alltrue(flatten([
      for b in var.buildings : [for f in coalesce(b.floors, []) : [for r in coalesce(f.rooms, []) : [for row in coalesce(r.rows, []) : [for rack in coalesce(row.racks, []) : [for node in coalesce(rack.nodes, []) : node.id >= 1 && node.id <= 4000]]]]]
    ]))
    error_message = "Allowed values `id`: 1-4000."
  }

  validation {
    condition = alltrue(flatten([
      for b in var.buildings : [for f in coalesce(b.floors, []) : [for r in coalesce(f.rooms, []) : [for row in coalesce(r.rows, []) : [for rack in coalesce(row.racks, []) : [for node in coalesce(rack.nodes, []) : node.pod == null || try(node.pod >= 1 && node.pod <= 255)]]]]]
    ]))
    error_message = "Allowed values `pod`: 1-255."
  }
}
