module Mutations
  class CreateTodo < BaseMutation
    argument :title, String, required: true
    argument :description, String, required: false
    argument :completed, Boolean, required: false, default_value: false

    field :todo, Types::TodoType, null: true
    field :errors, [String], null: false

    def resolve(title:, description: nil, completed: false)
      todo = Todo.new(
        title: title,
        description: description,
        completed: completed
      )

      if todo.save
        {
          todo: todo,
          errors: []
        }
      else
        {
          todo: nil,
          errors: todo.errors.full_messages
        }
      end
    end
  end
end 