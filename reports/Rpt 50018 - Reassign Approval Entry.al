report 50018 "Reassign Approval entry"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Approval Entry"; "Approval Entry")
        {

            trigger OnPreDataItem();
            begin
                if IsConfirmed then begin
                    ApprovalEntry.SETRANGE("Table ID", RecIDNo);
                    ApprovalEntry.SETRANGE("Record ID to Approve", RecID);
                    ApprovalEntry.SETFILTER(Status, '%1|%2', ApprovalEntry.Status::Created, ApprovalEntry.Status::Open);
                    ApprovalEntry.SETRANGE("Related to Change", false);
                    if ApprovalEntry.findfirst then begin
                        if "Sender ID" <> USERID then begin
                            ApprovalEntry."Sender ID" := USERID;
                            ApprovalEntry.MODIFY;
                            Message('The Requestor ID was sucessfully reassigned.');
                        end;
                    end;
                end else
                    exit;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        IsConfirmed := DIALOG.CONFIRM('This action will reassign you as the requestor, Do you want to continue', true);
    end;

    var
        RecIDNo: Integer;
        RecID: RecordID;
        ApprovalEntry: Record "Approval Entry";
        IsConfirmed: Boolean;

    procedure SetRecordID(ForRecNo: Integer; ForRecordID: RecordID);
    begin
        RecIDNo := ForRecNo;
        RecID := ForRecordID
    end;
}

