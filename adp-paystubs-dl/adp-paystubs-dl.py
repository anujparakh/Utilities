import requests
import adpCookie
# Anything in or before this year won't be saved
CUTOFF_YEAR = 2020

folder = input('Enter folder to save downloaded paystubs: ')

response = requests.get("https://my.adp.com/v1_0/O/A/payStatements?adjustments=yes&numberoflastpaydates=300", headers={"Cookie": adpCookie.cookie})

for statement in (response.json()["payStatements"]):
    payDate = statement["payDate"]
    if(int(payDate[:4]) <= CUTOFF_YEAR):
        continue

    print(f'Saving {payDate}...')

    # Make request
    pdfUrl = f'https://my.adp.com/{statement["statementImageUri"]["href"][4:]}'
    pdfResponse = requests.get(pdfUrl, headers={"Cookie": adpCookie.cookie})


    # Write file
    fileName = f'{payDate}-paystub.pdf'
    file = open(f'{folder}/{fileName}', 'wb')
    file.write(pdfResponse.content)
    file.close()

    print('Done')
