namespace TheGoofyTask.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class FirstMigration : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.PersonModals",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(),
                        Email = c.String(),
                        Category = c.Int(nullable: false),
                        IsSmart = c.Boolean(nullable: false),
                        IsDead = c.Boolean(nullable: false),
                        LikesLizards = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.Id);
            
        }
        
        public override void Down()
        {
            DropTable("dbo.PersonModals");
        }
    }
}
