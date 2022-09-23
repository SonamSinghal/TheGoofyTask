using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TheGoofyTask.Modals
{
    public class PersonModal
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public CategoryEnum Category { get; set; }
        public bool IsSmart { get; set; }
        public bool IsDead { get; set; } = false;
        public bool LikesLizards { get; set; }
    }
}