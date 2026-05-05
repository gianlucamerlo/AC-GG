import { Component, inject, OnInit, signal } from "@angular/core";
import { CommonModule } from "@angular/common";
import { ReactiveFormsModule, FormBuilder, Validators } from "@angular/forms";
import { ForumService } from "../../core/services/forum.service";
import { BaseComponent } from "../../shared/base.component";

@Component({
  selector: "app-admin-forum",
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: "./admin-forum.component.html",
  styleUrls: ["./admin-forum.component.css"]
})
export class AdminForumComponent extends BaseComponent implements OnInit {
  private forumService = inject(ForumService);
  private fb = inject(FormBuilder);

  categories = signal<any[]>([]);
  editingId = signal<number | null>(null);

  form = this.fb.nonNullable.group({
    name: ["", Validators.required],
    description: [""],
  });

  ngOnInit(): void {
    this.loadCategories();
  }

  loadCategories(): void {
    this.forumService.getCategories().subscribe({
      next: (data) => this.categories.set(data),
    });
  }

  save(): void {
    const value = this.form.getRawValue();
    const request$ = this.editingId()
        ? this.forumService.updateCategory(this.editingId()!, value)
        : this.forumService.createCategory(value);

    request$.subscribe({
      next: () => {
        this.loadCategories();
        this.cancelEdit();
      },
    });
  }

  startEdit(cat: any): void {
    this.editingId.set(cat.id);
    this.form.setValue({ name: cat.name, description: cat.description ?? "" });
  }

  cancelEdit(): void {
    this.editingId.set(null);
    this.form.reset();
  }

  delete(id: number): void {
    if (confirm("Sei sicura di voler eliminare questa categoria?")) {
      this.forumService.deleteCategory(id).subscribe({
        next: () => this.loadCategories(),
      });
    }
  }
}