function ViewPerson() {
    var _self = this;
    _self.People = ko.observableArray();
    _self.personName = ko.observable('');
    _self.personEmail = ko.observable('');
    _self.personCategory = ko.observable('');
    _self.personIsSmart = ko.observable(false);
    _self.personLikesLizards = ko.observable(false);

    _self.emailFilter = ko.observable("");
    _self.isSmartFilter = ko.observable(false);
    _self.isDeadFilter = ko.observable(false);
    _self.likesLizardsFilter = ko.observable(false);

    let modelId;

    _self.CreatePerson = function () {
        if (required($("#name").val()) && validEmail($("#email").val())) {
            let name = $("#name").val();
            let email = $("#email").val();
            let category = $("#category").val();
            let isSmart = $("#isSmart").attr("checked") ? true : false;
            let likesLizards = $("#likesLizards").attr("checked") ? true : false;
            let person = { Name: name, Email: email, Category: category, IsSmart: isSmart, LikesLizards: likesLizards };

            $("#name").val("");
            $("#email").val("");
            $("#category").val("");
            $("#likesLizards").prop('checked', false)
            $("#isSmart").prop('checked', false)

            $.ajax({
                type: "POST",
                url: "/WebService.asmx/CreatePerson",
                data: JSON.stringify({ modal: person }),
                dataType: "json",
                contentType: 'application/json',
                success: function (data) {
                    GetPeople();
                },
                error: function (err) {
                    console.log(err.responseText);
                }

            })
        }
    }

    _self.GetPerson = function (person) {
        $("#editModal").modal("toggle");
        _self.personName(person.Name);
        _self.personEmail(person.Email);
        _self.personCategory(person.Category);
        _self.personIsSmart(person.IsSmart);
        _self.personLikesLizards(person.LikesLizards);
        modelId = person.Id;
    }

    _self.EditPerson = function () {
        if (required(_self.personName()) && validEmail(_self.personEmail())) {
        $("#editModal").modal("hide");
            let model = _self.People().find(x => x.Id == modelId);
            model.Name = _self.personName();
            model.Email = _self.personEmail();
            model.Category = _self.personCategory();
            model.IsSmart = _self.personIsSmart();
            model.LikesLizards = _self.personLikesLizards();

            let person = { Id: model.Id, Name: model.Name, Email: model.Email, Category: model.Category, IsSmart: model.IsSmart, IsDead: model.IsSmart, LikesLizards: model.LikesLizards };

            _self.personName = ko.observable("");
            _self.personEmail = ko.observable("");
            _self.personCategory = ko.observable("");
            _self.personIsSmart = ko.observable(false);
            _self.personLikesLizards = ko.observable(false);

        $.ajax({
            type: "POST",
            url: "/WebService.asmx/EditPerson",
            data: JSON.stringify({ modal: person }),
                dataType: "json",
                contentType: 'application/json',
                success: function (data) {
                    GetPeople();
                },
                error: function (err) {
                    console.log(err.responseText);
                }

            })
        }
    } 

    _self.KillPerson = function (person) {
        $.ajax({
            type: "POST",
            url: "/WebService.asmx/KillPerson",
            data: JSON.stringify({ personId: person.Id }),
            dataType: "json",
            contentType: 'application/json',
            success: function () {
                GetPeople();
            },
            error: function (err) {
                console.log(err.responseText);
            }
        })
    }
}

var ViewPersonViewModel = new ViewPerson();
ko.applyBindings(ViewPersonViewModel);
GetPeople();

function GetPeople(){
    $.ajax({
        type: "POST",
        url: "/WebService.asmx/GetAlivePeople",
        data: JSON.stringify({ emailFitler: ViewPersonViewModel.emailFilter(), isSmartFilter: ViewPersonViewModel.isSmartFilter(), isDeadFilter: ViewPersonViewModel.isDeadFilter(), likesLizards: ViewPersonViewModel.likesLizardsFilter() }),
        dataType: "json",
        contentType: 'application/json',
        success: function (data) {
            ViewPersonViewModel.People(data.d);
            ViewPersonViewModel.People.vis = ko.observable(true);
        },
        error: function (err) {
            console.log(err.responseText);
        }
    })
}


function required(attr) {
    if (attr == "" || attr == " ") {
        alert("The Name Field must not be empty!")
        return false;
    }
    return true;
}

function validEmail(email) {
    var emailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    if (email.match(emailformat)) {
        return true;
    }
    else {
        alert("You have entered an invalid email address!");
        return false;
    }
}



function GetUpdatedList() {
    if (ViewPersonViewModel.emailFilter().length == 0)
        GetPeople();
    else {
        if (ViewPersonViewModel.emailFilter().length >= 4) {
            GetPeople();
        }
        else {
            alert("The email filter should be atleast 4 characters");
        }
    }

}
