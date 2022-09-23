using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using TheGoofyTask.Modals;
using TheGoofyTask.Repository;

namespace TheGoofyTask
{
    /// <summary>
    /// Summary description for WebService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class WebService : System.Web.Services.WebService
    {

        private readonly PersonRepository _personRepository = new PersonRepository();


        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod]
        public List<PersonModal> GetAlivePeople(string emailFitler, bool isSmartFilter, bool isDeadFilter, bool likesLizards)
        {
            List<PersonModal> people = _personRepository.GetAllPeople();
            people = string.IsNullOrEmpty(emailFitler) ? people : people.Where(x => x.Email.ToUpper().StartsWith(emailFitler.ToUpper())).ToList();
            people = !isDeadFilter ? people.Where(x=>x.IsDead == false).ToList() : people;
            people = !isSmartFilter ? people : people.Where(x => x.IsSmart == true).ToList();
            people = !likesLizards ? people : people.Where(x => x.LikesLizards == true).ToList();

            return people;
        }

        [WebMethod]
        public void CreatePerson(PersonModal modal)
        {
            _personRepository.AddPerson(modal);
        }

        [WebMethod]
        public void KillPerson(int personId)
        {
            _personRepository.KillPerson(personId);
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void EditPerson(PersonModal modal)
        {
            _personRepository.EditPerson(modal);
        }
    }
}
