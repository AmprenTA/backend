# frozen_string_literal: true

class FoodsApi < Grape::API
  resource :foods do
    # POST /foods
    desc 'Create foods' do
      tags %w[foods]
      http_codes [
        { code: 201, message: 'Create foods' },
        { code: 400, message: 'Bad request!' }
      ]
    end
    desc 'Headers', {
      headers: {
        'Auth-Token' => {
          description: 'Validates your identity',
          optional: true
        }
      }
    }
  end
end
