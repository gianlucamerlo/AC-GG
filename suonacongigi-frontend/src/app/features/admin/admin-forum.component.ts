import { Component, inject, OnInit, signal } from "@angular/core";
import { CommonModule } from "@angular/common";
import { ReactiveFormsModule, FormBuilder, Validators } from "@angular/forms";
import { ForumService } from "../../core/services/forum.service";
import { BaseComponent } from "../../shared/base.component"; //

@Component({
  selector: "app-admin-forum",
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  template: `
    <div class="admin-forum">
      <h2>Gestione categorie forum</h2>
      <div class="form-box">
        <h3>{{ editingId() ? "Modifica categoria" : "Nuova categoria" }}</h3>
        <form [formGroup]="form">
          <input formControlName="name" placeholder="Nome categoria" />
          @if (form.get("name")?.invalid && form.get("name")?.touched) {
            <span class="error">Il nome è obbligatorio</span>
          }
          <input formControlName="description" placeholder="Descrizione" />
          <div class="form-actions">
            <button (click)="save()" [disabled]="form.invalid">
              {{ editingId() ? "Salva modifiche" : "Crea categoria" }}
            </button>
            @if (editingId()) {
              <button class="secondary" (click)="cancelEdit()">Annulla</button>
            }
          </div>
        </form>
      </div>
      <div class="category-list">
        @for (cat of categories(); track cat.id) {
          <div class="category-row">
            <div class="info">
              <strong>{{ cat.name }}</strong>
              <p>{{ cat.description }}</p>
            </div>
            <div class="actions">
              <button (click)="startEdit(cat)">Modifica</button>
              <button class="danger" (click)="delete(cat.id)">Elimina</button>
            </div>
          </div>
        }
      </div>
    </div>
  `,
  styles: [
    `
      .admin-forum {
        padding: 1rem;
        font-family: sans-serif;
      }
      .form-box {
        background: #f4f7f6;
        padding: 1.5rem;
        border-radius: 8px;
        margin-bottom: 2rem;
      }
      .form-actions {
        display: flex;
        gap: 10px;
        margin-top: 1rem;
      }
      input {
        display: block;
        width: 100%;
        padding: 0.5rem;
        margin-bottom: 0.5rem;
        border: 1px solid #ccc;
        border-radius: 4px;
      }
      .category-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 1rem;
        border-bottom: 1px solid #eee;
      }
      .info p {
        margin: 0;
        color: #666;
        font-size: 0.9rem;
      }
      .actions {
        display: flex;
        gap: 8px;
      }
      .error {
        color: red;
        font-size: 0.8rem;
        display: block;
        margin-bottom: 0.5rem;
      }
      button {
        padding: 0.5rem 1rem;
        cursor: pointer;
        border-radius: 4px;
        border: none;
        background: #00796b;
        color: white;
      }
      button:disabled {
        background: #ccc;
      }
      button.secondary {
        background: #607d8b;
      }
      button.danger {
        background: #d32f2f;
      }
    `,
  ],
})
export class AdminForumComponent extends BaseComponent implements OnInit {
  private forumService = inject(ForumService); //[cite: 2]
  private fb = inject(FormBuilder); //[cite: 2]

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
      // L'errore è gestito dall'intercettore globale come in admin-dashboard[cite: 2]
    });
  }

  save(): void {
    const value = this.form.getRawValue();
    const request$ = this.editingId() ? this.forumService.updateCategory(this.editingId()!, value) : this.forumService.createCategory(value);

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
