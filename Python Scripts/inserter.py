import firebase_admin
from firebase_admin import credentials, firestore
from datasets import meds  # Assuming meds is a list of dictionaries

# Initialize Firebase with your configuration file
cred = credentials.Certificate('manzo_key.json')
firebase_admin.initialize_app(cred)

db = firestore.client()

# General function to add items to Firestore
def add_items_to_firestore(db, collection_name, items):
    for item in items:
        # Add each item to the specified Firestore collection
        db.collection(collection_name).add(item)
        print(f'Added: {item}')  # Print the added item

# Example usage:
# Specify the Firestore collection name and directly pass the meds list
add_items_to_firestore(db, 'generalMedicine', meds)
