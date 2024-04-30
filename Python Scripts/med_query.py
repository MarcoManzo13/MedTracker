import requests

def get_drug_information(drug_name):
    # OpenFDA API endpoint for drug label information
    api_url = 'https://api.fda.gov/drug/label.json'
    
    # Parameters for the API request
    # Using 'search' parameter to filter results by drug brand name
    params = {
        'search': f'openfda.brand_name:"{drug_name}"',
        'limit': 1  # Assuming we only want the most relevant result
    }
    
    # Send the request to OpenFDA
    response = requests.get(api_url, params=params)
    
    # Check if the response was successful
    if response.status_code == 200:
        data = response.json()
        results = data.get('results', [])
        if results:
            result = results[0]
            # Print general drug information
            print(f"Information for {drug_name}:")
            print(f"  - Purpose: {result.get('purpose', ['No purpose information'])[0]}")
            print(f"  - Active Ingredient: {result.get('active_ingredient', ['No active ingredient information'])[0]}")
            if 'warnings' in result:
                print("  - Warnings:")
                for warning in result['warnings']:
                    print(f"    - {warning}")
        else:
            print("No information found for this drug.")
    else:
        print("Failed to retrieve data:", response.status_code)

# Example usage with 'Advil'
get_drug_information('Advil')
