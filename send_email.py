import os
from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import Mail

message = Mail(
    from_email='danielsanabria89@gmail.com',
    to_emails='danielsanabria89@gmail.com',
    subject='Estado del Pipeline CI/CD',
    html_content='<strong>El pipeline se ha ejecutado exitosamente.</strong>'
)
try:
    sg = SendGridAPIClient(os.environ.get('SENDGRID_API_KEY'))
    response = sg.send(message)
    print(response.status_code)
    print(response.body)
    print(response.headers)
except Exception as e:
    print(e.message)
