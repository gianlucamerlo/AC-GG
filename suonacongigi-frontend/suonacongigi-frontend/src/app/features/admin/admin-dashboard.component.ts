import { Component, inject, OnInit, signal } from "@angular/core";
import { DatePipe } from "@angular/common";
import { DashboardService, Stats } from "../../core/services/dashboard.service";
import { UserService } from "../../core/services/user.service";
import { UserProfile } from "../../core/models/user.model";
import { BaseComponent } from "../../shared/base.component";
import { AdminForumComponent } from "./admin-forum.component";

@Component({
  selector: "app-admin-dashboard",
  standalone: true,
  imports: [DatePipe, AdminForumComponent],
  templateUrl: "./admin-dashboard.component.html",
  styleUrls: ["./admin-dashboard.component.css"],
})
export class AdminDashboardComponent extends BaseComponent implements OnInit {
  private dashboardService = inject(DashboardService);
  private userService = inject(UserService);

  stats = signal<Stats | null>(null);
  users = signal<UserProfile[]>([]);

  ngOnInit(): void {
    this.dashboardService.getDashboardStats().subscribe({
      next: (data) => this.stats.set(data)
    });
    this.loadUsers();
  }

  loadUsers(): void {
    this.userService.getAll().subscribe({
      next: (data) => this.users.set(data)
    });
  }

  toggleEnabled(user: UserProfile): void {
    const action$ = user.enabled
      ? this.userService.disableUser(user.id)
      : this.userService.enableUser(user.id);

    action$.subscribe({
      next: () => this.loadUsers()
    });
  }
}
