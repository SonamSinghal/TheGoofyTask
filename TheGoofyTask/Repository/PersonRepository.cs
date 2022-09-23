using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using TheGoofyTask.Data;
using TheGoofyTask.Modals;

namespace TheGoofyTask.Repository
{
    public class PersonRepository :DbContext
    {

        public PersonRepository() : base("DbConnection")
        {
            Database.SetInitializer(new MigrateDatabaseToLatestVersion<ApplicationDbContext, Migrations.Configuration>());
        }

        public DbSet<PersonModal> PersonModal { get; set; }

        public List<PersonModal> GetAllPeople()
        {
            return PersonModal.ToList();
        }

        public void AddPerson(PersonModal modal)
        {
            var person = new PersonModal()
            {
                Name = modal.Name,
                Email = modal.Email,
                Category = modal.Category,
                IsSmart = modal.IsSmart,
                LikesLizards = modal.LikesLizards
            };

            PersonModal.Add(person);
            SaveChanges();
        }

        public void EditPerson(PersonModal modal)
        {
            var person = PersonModal.FirstOrDefault(x => x.Id == modal.Id);
            if (person != null)
            {
                person.Name = modal.Name;
                person.Email = modal.Email;
                person.Category = modal.Category;
                person.IsSmart = modal.IsSmart;
                person.LikesLizards = modal.LikesLizards;
            }
            SaveChanges();
        }

        public void KillPerson(int personId)
        {
            var person = PersonModal.FirstOrDefault(x => x.Id == personId);
            if (person != null)
            {
                person.IsDead = true;
            }
            SaveChanges();
        }
    }
}