json.extract! claim_status, :id, :name, :description, :created_at, :updated_at
json.url claim_status_url(claim_status, format: :json)
