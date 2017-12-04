json.extract! claim_type, :id, :name, :description, :created_at, :updated_at
json.url claim_type_url(claim_type, format: :json)
