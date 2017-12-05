import requests
import json

data = """
Age 70 years or older.
Must have a clinical diagnosis of Alzheimer's Disease.
Life expectancy less than 1 year.
Subjects must be in reasonably good health, based on medical history, physical examination, vital signs, and ECG.
Subjects with a past or current history of seizures cannot participate.
Subjects with clinically significant heart disease, pulmonary disease, diabetes, neurologic or psychiatric disease (Group 1 subjects must have Alzheimer's Disease), or any other illness that could interfere with interpretation of study results.
Current use of donepezil, rivastigmine or galantamine.
GDS-5 score < 6.
Within the previous 2 years, unstable and clinically siginificant cardivascular disease.
"""
url = 'http://192.168.99.100:5000/'
r = requests.post(url, data={'data': data})

print r.text
