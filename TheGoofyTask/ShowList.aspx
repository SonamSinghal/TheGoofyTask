<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ShowList.aspx.cs" Inherits="TheGoofyTask.ShowList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .bg-dead {
            background-color: #669999;
            color:  rgba(255,255,255,.5);
        }

        .bg-dead:hover{
            color:  rgba(0,0,0,.5);
        }

        .d-none{
            display:none;
        }

    </style>
    <fieldset style="background-color:#85adad">
        <legend>Create new Person</legend>
            <div class="" style="padding: 20px;">
                <div>
                    <label>Name: </label>
                    <input id="name" type="text"  class="form-control" />
                </div>
                  <div>
                    <label>Email: </label>
                    <input id="email" type="email"  class="form-control" />
                </div>
                  <div>
                      <label>Select a Category: </label>
                      <select id="category" class="form-control" >
                          <option value="" selected disabled>Select a Value</option>
                          <option value="0">Hot</option>
                          <option value="1">Cool</option>
                      </select>
                  </div>
                  <div>
                    <label>Is Person Smart? </label>
                    <input id="isSmart" type="checkbox"  class="form-check-input" data-bind="checked: personIsSmart" />
                </div>
                  <div>
                    <label>Does He/She likes Lizards: </label>
                    <input id="likesLizards" type="checkbox"  class="form-check-input" data-bind="checked: personLikesLizards" />
                </div>
                <div>
                    <button type="button" class="btn-primary" data-bind="click: CreatePerson">
                        Create New Person 
                        <i class="fa-sharp fa-solid fa-plus"></i>
                    </button>
                </div>
            </div>
    </fieldset>
    
    <fieldset style="padding:20px; margin-top:20px; margin-bottom:20px; background-color:#ffffcc;">
        <legend>Add a Filter!</legend>
        <div>
            <div>
                <label>Email:</label>
                <input type="email" class="form-control" data-bind="value: emailFilter"  />
            </div>
            <div>
                <label>Show only Smart People: </label>
                <input type="checkbox" class="form-check-input" data-bind="checked: isSmartFilter"  />
            </div>
              <div>
                <label>Show Dead People also: </label>
                <input type="checkbox" class="form-check-input" data-bind="checked: isDeadFilter" />
            </div>
            <div>
                <label>Show People who Likes Lizards: </label>
                <input type="checkbox" class="form-check-input" data-bind="checked: likesLizardsFilter" />
            </div>
        </div>

        <div>
            <button type="button" class="btn-primary" onclick="GetUpdatedList()">Apply Filter <i class="fa-sharp fa-solid fa-filter"></i></button>
        </div>
    </fieldset>


    <table class="table table-dark table-hover">
        <thead>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Category</th>
                <th>Is Smart?</th>
                <th>Likes Lizards?</th>
                <th></th>
                <th></th>
            </tr>
        </thead>
        <tbody data-bind="foreach: People">
                <tr data-bind="class: ((IsDead == false) ?((Category == 0) ? 'bg-danger' : 'bg-info') : 'bg-dead')">
                    <td data-bind="text: Name">
                        <div data-bind="if: Name == 'sonam'" >
                        <span>Hello1</span>
                        </div>
                        <div data-bind="if: vis == true" >
                        <span>Hello2</span>
                        </div>
                        <div data-bind="if: vis()" >
                        <span>Hello3</span>
                        </div>
                        <div data-bind="if: vis() == true" >
                        <span>Hello4</span>
                        </div>
                        <div data-bind="if: vis" >
                        <span>Hello5</span>
                        </div>
                        
                    </td>
                    <td data-bind="text: Email"></td>
                    <td data-bind="text: ((Category == 0) ? 'Hot' : 'Cool'), class: ((Category == 0) ? 'text-danger' : 'text-primary')"></td>
                    <td data-bind="text: ((IsSmart == true) ? 'Yes' : 'No')"></td>
                    <td data-bind="text: ((LikesLizards == true) ? 'Yes' : 'No')"></td>
                    
                    <td>
                        <button type="button" class="alert-info"
                         data-bind="click: $parent.GetPerson">
                            <i class="fa-sharp fa-solid fa-marker"></i>
                        </button>
                    </td>
                    <td>
                        <button type="button" role="button" data-bind="click: $parent.KillPerson, class: ((IsDead == false) ? 'btn-danger' : 'd-none')">
                            
                            <i class="fa-solid fa-skull"></i>
                        </button>
                    </td>
                </tr>
        </tbody>
    </table>



    <%--EDIT MODAL--%>
    <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="editModalLabel">Edit Student</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <div>
                <label>Name: </label>
                <input type="text" data-bind="value: personName" />
            </div>
              <div>
                <label>Email: </label>
                <input type="email" data-bind="value: personEmail" />
            </div>
              <div>
                  <label>Select a Category: </label>
                  <select data-bind="value: personCategory">
                      <option value="0">Hot</option>
                      <option value="1">Cool</option>
                  </select>
              </div>
              <div>
                <label>Is Person Smart? </label>
                <input type="checkbox" data-bind="checked: personIsSmart" />
            </div>
              <div>
                <label>Does He/She likes Lizards: </label>
                <input type="checkbox" data-bind="checked: personLikesLizards" />
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary" data-bind="click: EditPerson">Save changes</button>
          </div>
        </div>
      </div>
    </div>

    <script src="JSFiles/JavascriptFile.js"></script>
</asp:Content>
