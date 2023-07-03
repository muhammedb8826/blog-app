require 'swagger_helper'

describe 'Posts API' do
  path '/users/{user_id}/posts' do
    get 'Retrieves posts for a user' do
      tags 'Posts'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer
      # request_body_example value: { some_field: 'Foo' }, name: 'basic', summary: 'Request example description'

      response '200', 'Posts retrived successfully' do
        schema type: :object,
               properties: {
                 user_id: { type: :integer },
                 title: { type: :string },
                 text: { type: :string }
               },
               required: %w[user_id title text]

        let(:user_id) { Post.create(title: 'foo', text: 'bar').user_id }
        run_test!
      end

      response '404', 'User not found' do
        let(:user_id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:Accept) { 'application/foo' }
        run_test!
      end
    end
  end
end
