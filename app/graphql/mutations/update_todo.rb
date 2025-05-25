module Mutations
  class UpdateTodo < BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :description, String, required: false
    argument :completed, Boolean, required: false

    field :todo, Types::TodoType, null: true
    field :errors, [String], null: false

    def resolve(id:, **attributes)
      todo = Todo.find_by(id: id)
      return { todo: nil, errors: ["Todo not found"] } unless todo

      if todo.update(attributes)
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