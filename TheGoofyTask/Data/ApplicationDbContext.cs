using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using TheGoofyTask.Modals;

namespace TheGoofyTask.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext():base("DbConnection")
        {
            Database.SetInitializer(new MigrateDatabaseToLatestVersion<ApplicationDbContext, Migrations.Configuration>());
        }

        public DbSet<PersonModal> PersonModal { get; set; }
    }
}