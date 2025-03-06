import win32com.client
import datetime

Outlook = win32com.client.Dispatch("Outlook.Application")
ns = Outlook.GetNamespace("MAPI")
appointments = ns.GetDefaultFolder(9).Items
appointments.Sort("[Start]")
appointments.IncludeRecurrences = "True"
begin = datetime.date.today().strftime("%m/%d/%Y")
end = (datetime.date.today() + datetime.timedelta(days=1)).strftime("%m/%d/%Y")
restrictedItems = appointments.Restrict(
    "[Start] >= '" + begin + "' AND [END] <= '" + end + "'")

for appointmentItem in restrictedItems:
    print(f"## {appointmentItem.Subject}\n\n**Start:** {appointmentItem.Start}\n\n**End:** {appointmentItem.End}\n\n**Location:** {appointmentItem.Location}\n\n**Description:** {appointmentItem.Body}\n\n---\n")
